import { Module } from '@nestjs/common';
import { KelasService } from './kelas.service';
import { KelasController } from './kelas.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Kelas } from './entities/kelas.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Kelas])],
  controllers: [KelasController],
  providers: [KelasService],
})
export class KelasModule {}
