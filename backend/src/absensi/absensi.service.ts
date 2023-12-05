import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateAbsensiDto } from './dto/create-absensi.dto';
import { UpdateAbsensiDto } from './dto/update-absensi.dto';
import { Absensi } from './entities/absensi.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Mahasiswa } from 'src/mahasiswa/entities/mahasiswa.entity';
import { Kelas } from 'src/kelas/entities/kelas.entity';
import * as moment from 'moment-timezone';

@Injectable()
export class AbsensiService {
  constructor(
    @InjectRepository(Absensi)
    private absensiRepository: Repository<Absensi>,
    @InjectRepository(Mahasiswa)
    private mahasiswaRepository: Repository<Mahasiswa>,
  ) { }

  async getKehadiran(idKelas: number, mingguKe: number) {
    const absenHadir = await this.absensiRepository
      .createQueryBuilder('a')
      .leftJoinAndSelect('a.kelas', 'k')
      .leftJoinAndSelect('a.mahasiswa', 'm')
      .where('k.id = :idKelas', { idKelas })
      .andWhere('a.minggu_ke = :mingguKe', { mingguKe })
      .select([
        'm.id',
        'm.nama',
        'm.npm',
        'a.id',
        'a.minggu_ke',
        'a.waktu_masuk',
        'a.waktu_keluar',
        'k',
      ])
      .getMany();

    const mahasiswaKelas = await this.mahasiswaRepository
      .createQueryBuilder('m')
      .leftJoin('m.kelas', 'k')
      .where('k.id = :idKelas', { idKelas })
      .select(['m.id', 'm.nama', 'm.npm', 'k']);

    if (absenHadir.length == 0) {
      return {
        hadir: [],
        tidakHadir: await mahasiswaKelas.getMany(),
      };
    }

    const absenTidakHadir = await mahasiswaKelas
      .andWhere('m.id NOT IN (:...hadirAbsen)', {
        hadirAbsen: absenHadir.map((a) => a.mahasiswa.id),
      })
      .getMany();

    return {
      hadir: absenHadir,
      tidakHadir: absenTidakHadir,
    };
  }

  async absenMasuk(kelas: Kelas, mahasiswa: Mahasiswa, minggu_ke: number) {
    const absen = await this.absensiRepository.findOneBy({
      kelas,
      mahasiswa,
      minggu_ke,
    });

    if (absen) {
      throw new HttpException(
        'Mahasiswa sudah absen masuk',
        HttpStatus.BAD_REQUEST,
      );
    }

    return await this.absensiRepository.save({
      kelas,
      mahasiswa,
      minggu_ke,
    });
  }
  async absenKeluar(kelas: Kelas, mahasiswa: Mahasiswa, minggu_ke: number) {
    const absen = await this.absensiRepository.findOneBy({
      kelas,
      mahasiswa,
      minggu_ke,
    });
    if (!absen) {
      throw new HttpException(
        'Mahasiswa belum absen masuk',
        HttpStatus.BAD_REQUEST,
      );
    }
    if (absen.waktu_keluar != null) {
      throw new HttpException('Mahasiswa sudah keluar', HttpStatus.BAD_REQUEST);
    }
    const absenBaru = await this.absensiRepository.findOneBy({
      kelas,
      mahasiswa,
      minggu_ke,
    });
    absenBaru.waktu_keluar = moment().tz('Asia/Jakarta').toDate();
    return await this.absensiRepository.save(absenBaru);
  }

  create(createAbsensiDto: CreateAbsensiDto) {
    return 'This action adds a new absensi';
  }

  async findAll() {
    return await this.absensiRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} absensi`;
  }

  update(id: number, updateAbsensiDto: UpdateAbsensiDto) {
    return `This action updates a #${id} absensi`;
  }

  async remove(id: number) {
    const absen = await this.absensiRepository.findOneBy({ id });
    console.log(absen);
    if (!absen) {
      throw new HttpException('Absen does not exist', HttpStatus.BAD_REQUEST);
    }

    return await this.absensiRepository.remove(absen);
  }
}
