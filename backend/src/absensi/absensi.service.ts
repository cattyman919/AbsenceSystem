import { Injectable } from '@nestjs/common';
import { CreateAbsensiDto } from './dto/create-absensi.dto';
import { UpdateAbsensiDto } from './dto/update-absensi.dto';
import { Absensi } from './entities/absensi.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class AbsensiService {
  constructor(
    @InjectRepository(Absensi)
    private absensiRepository: Repository<Absensi>,
  ) {}

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
