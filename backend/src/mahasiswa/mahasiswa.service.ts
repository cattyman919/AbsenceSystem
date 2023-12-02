import { Injectable } from '@nestjs/common';
import { CreateMahasiswaDto } from './dto/create-mahasiswa.dto';
import { UpdateMahasiswaDto } from './dto/update-mahasiswa.dto';
import { Mahasiswa } from './entities/mahasiswa.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class MahasiswaService {
  constructor(
    @InjectRepository(Mahasiswa)
    private mahasiswaRepository: Repository<Mahasiswa>,
  ) {}

  create(createMahasiswaDto: CreateMahasiswaDto) {
    return 'This action adds a new mahasiswa';
  }

  async findAll() {
    return await this.mahasiswaRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} mahasiswa`;
  }

  update(id: number, updateMahasiswaDto: UpdateMahasiswaDto) {
    return `This action updates a #${id} mahasiswa`;
  }

  remove(id: number) {
    return `This action removes a #${id} mahasiswa`;
  }
}
