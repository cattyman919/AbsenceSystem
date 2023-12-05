import { Module } from '@nestjs/common';
import { MahasiswaService } from './mahasiswa.service';
import { MahasiswaController } from './mahasiswa.controller';
import { Mahasiswa } from './entities/mahasiswa.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Kelas } from 'src/kelas/entities/kelas.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Mahasiswa, Kelas])],
  controllers: [MahasiswaController],
  providers: [MahasiswaService],
  exports: [MahasiswaService]
})
export class MahasiswaModule { }
