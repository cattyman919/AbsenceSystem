import { Module } from '@nestjs/common';
import { AbsensiService } from './absensi.service';
import { AbsensiController } from './absensi.controller';
import { Absensi } from './entities/absensi.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Absensi])],
  controllers: [AbsensiController],
  providers: [AbsensiService],
})
export class AbsensiModule {}
