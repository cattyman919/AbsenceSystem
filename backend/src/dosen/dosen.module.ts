import { Module } from '@nestjs/common';
import { DosenService } from './dosen.service';
import { DosenController } from './dosen.controller';
import { Dosen } from './entities/dosen.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Dosen])],
  controllers: [DosenController],
  providers: [DosenService],
})
export class DosenModule {}
