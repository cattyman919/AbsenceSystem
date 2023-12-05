import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Query,
  Delete,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { AbsensiService } from './absensi.service';
import { CreateAbsensiDto } from './dto/create-absensi.dto';
import { UpdateAbsensiDto } from './dto/update-absensi.dto';
import { Absensi } from './entities/absensi.entity';
import { KelasService } from 'src/kelas/kelas.service';
import { MahasiswaService } from 'src/mahasiswa/mahasiswa.service';

@Controller('absensi')
export class AbsensiController {
  constructor(
    private readonly absensiService: AbsensiService,
    private readonly mahasiswaService: MahasiswaService,
    private readonly kelasService: KelasService,
  ) { }

  @Get('/kelas/:idKelas/minggu/:mingguKe')
  getKehadiran(
    @Param('idKelas') idKelas: number,
    @Param('mingguKe') mingguKe: number,
  ): Promise<any> {
    return this.absensiService.getKehadiran(idKelas, mingguKe);
  }

  @Post('absen-masuk')
  async absenMasuk(
    @Query('idKelas') idKelas: number,
    @Query('rfid_mahasiswa') rfid_mahasiswa: string,
    @Query('minggu_ke') minggu_ke: number,
  ) {
    const kelas = await this.kelasService.findOne(idKelas);
    const mahasiswa = await this.mahasiswaService.findOneByRFID(rfid_mahasiswa);
    const absen = await this.absensiService.findOneByMahasiswaAndMingguKe(
      mahasiswa,
      minggu_ke,
    );
    if (absen) {
      throw new HttpException(
        'Mahasiswa sudah absen masuk',
        HttpStatus.BAD_REQUEST,
      );
    }
    return await this.absensiService.absenMasuk(kelas, mahasiswa, minggu_ke);
  }
  @Post('absen-keluar')
  async absenKeluar(
    @Query('idKelas') idKelas: number,
    @Query('rfid_mahasiswa') rfid_mahasiswa: string,
    @Query('minggu_ke') minggu_ke: number,
  ) {
    const kelas = await this.kelasService.findOne(idKelas);
    const mahasiswa = await this.mahasiswaService.findOneByRFID(rfid_mahasiswa);
    const absen = await this.absensiService.findOneByMahasiswaAndMingguKe(
      mahasiswa,
      minggu_ke,
    );
    if (!absen) {
      throw new HttpException(
        'Mahasiswa belum absen masuk',
        HttpStatus.BAD_REQUEST,
      );
    }
    if (absen.waktu_keluar != null) {
      throw new HttpException('Mahasiswa sudah keluar', HttpStatus.BAD_REQUEST);
    }
    return await this.absensiService.absenKeluar(kelas, mahasiswa, minggu_ke);
  }

  @Post()
  create(@Body() createAbsensiDto: CreateAbsensiDto) {
    return this.absensiService.create(createAbsensiDto);
  }

  @Get()
  findAll() {
    return this.absensiService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.absensiService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateAbsensiDto: UpdateAbsensiDto) {
    return this.absensiService.update(+id, updateAbsensiDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.absensiService.remove(+id);
  }
}
