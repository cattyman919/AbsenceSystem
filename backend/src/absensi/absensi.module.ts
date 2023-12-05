import { Module } from '@nestjs/common';
import { AbsensiService } from './absensi.service';
import { AbsensiController } from './absensi.controller';
import { Absensi } from './entities/absensi.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MahasiswaModule } from 'src/mahasiswa/mahasiswa.module';
import { Mahasiswa } from 'src/mahasiswa/entities/mahasiswa.entity';
import { KelasModule } from 'src/kelas/kelas.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Absensi, Mahasiswa]),
    MahasiswaModule,
    KelasModule,
  ],
  controllers: [AbsensiController],
  providers: [AbsensiService],
})
export class AbsensiModule { }
