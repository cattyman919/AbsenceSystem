import { Injectable } from '@nestjs/common';
import { CreateKelasDto } from './dto/create-kelas.dto';
import { UpdateKelasDto } from './dto/update-kelas.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Kelas } from './entities/kelas.entity';
import { Repository } from 'typeorm';

@Injectable()
export class KelasService {
  constructor(
    @InjectRepository(Kelas)
    private kelasRepository: Repository<Kelas>,
  ) {}

  create(createKelaDto: CreateKelasDto) {
    return 'This action adds a new kela';
  }

  async findAll() {
    return await this.kelasRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} kela`;
  }

  update(id: number, updateKelaDto: UpdateKelasDto) {
    return `This action updates a #${id} kela`;
  }

  remove(id: number) {
    return `This action removes a #${id} kela`;
  }
}
