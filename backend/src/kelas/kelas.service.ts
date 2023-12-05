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
  ) { }

  async create(createKelasDto: CreateKelasDto) {
    return await this.kelasRepository.save(createKelasDto);
  }

  async findAll() {
    return await this.kelasRepository.find();
  }

  async findOne(id: number) {
    return this.kelasRepository.findOneBy({ id });
  }

  update(id: number, updateKelaDto: UpdateKelasDto) {
    return `This action updates a #${id} kela`;
  }

  remove(id: number) {
    return `This action removes a #${id} kela`;
  }
}
