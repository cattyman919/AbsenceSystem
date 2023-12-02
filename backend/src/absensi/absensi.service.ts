import { Injectable } from '@nestjs/common';
import { CreateAbsensiDto } from './dto/create-absensi.dto';
import { UpdateAbsensiDto } from './dto/update-absensi.dto';
import { Absensi } from './entities/absensi.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Mahasiswa } from 'src/mahasiswa/entities/mahasiswa.entity';

@Injectable()
export class AbsensiService {
  constructor(
    @InjectRepository(Absensi)
    private absensiRepository: Repository<Absensi>,
    @InjectRepository(Mahasiswa)
    private mahasiswaRepository: Repository<Mahasiswa>,
  ) {}

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
        'a.waktu_masuk',
        'a.waktu_keluar',
        'a.minggu_ke',
      ])
      .getMany();

    if (absenHadir.length == 0) {
      return {
        hadir: absenHadir,
        tidakHadir: [],
      };
    }

    const absenTidakHadir = await this.mahasiswaRepository
      .createQueryBuilder('m')
      .leftJoin('m.kelas', 'k')
      .where('k.id = :idKelas', { idKelas })
      .andWhere('m.id NOT IN (:...hadirAbsen)', {
        hadirAbsen: absenHadir.map((a) => a.mahasiswa.id),
      })
      .getMany();

    return {
      hadir: absenHadir,
      tidakHadir: absenTidakHadir,
    };
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

  remove(id: number) {
    return `This action removes a #${id} absensi`;
  }
}
