import { Injectable } from '@nestjs/common';
import { CreateDosenDto } from './dto/create-dosen.dto';
import { UpdateDosenDto } from './dto/update-dosen.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Dosen } from './entities/dosen.entity';

@Injectable()
export class DosenService {
  constructor(
    @InjectRepository(Dosen)
    private dosenRepository: Repository<Dosen>,
  ) {}

  create(createDosenDto: CreateDosenDto) {
    return 'This action adds a new dosen';
  }

  async findAll() {
    return await this.dosenRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} dosen`;
  }

  update(id: number, updateDosenDto: UpdateDosenDto) {
    return `This action updates a #${id} dosen`;
  }

  remove(id: number) {
    return `This action removes a #${id} dosen`;
  }
}
