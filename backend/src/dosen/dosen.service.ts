import {
  BadRequestException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { CreateDosenDto } from './dto/create-dosen.dto';
import { UpdateDosenDto } from './dto/update-dosen.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Dosen } from './entities/dosen.entity';
import * as bcrypt from 'bcrypt';

@Injectable()
export class DosenService {
  constructor(
    @InjectRepository(Dosen)
    private dosenRepository: Repository<Dosen>,
  ) {}

  async register(createDosenDto: CreateDosenDto): Promise<Dosen> {
    createDosenDto.password = await bcrypt.hash(createDosenDto.password, 10);
    try {
      const createdDosen = await this.dosenRepository.save(createDosenDto);
      console.log(createDosenDto);
      return createdDosen;
    } catch (error) {
      if (error?.code === '23505') {
        throw new HttpException(
          'Dosen with that username already exist',
          HttpStatus.BAD_REQUEST,
        );
      }
      throw new HttpException(
        'Something went wrong with the server',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async login(createDosenDto: CreateDosenDto): Promise<Dosen> {
    try {
      const dosen = await this.dosenRepository.findOneBy({
        username: createDosenDto.username,
      });
      if (!dosen) throw new BadRequestException('Dosen does not exist');
      await this.verifyPassword(createDosenDto.password, dosen.password);
      return dosen;
    } catch (error) {
      throw new HttpException(
        'Wrong credentials provided',
        HttpStatus.FORBIDDEN,
      );
    }
  }

  private async verifyPassword(
    plainTextPassword: string,
    hashedPassword: string,
  ) {
    const isPasswordMatching = await bcrypt.compare(
      plainTextPassword,
      hashedPassword,
    );
    if (!isPasswordMatching)
      throw new HttpException(
        'Wrong credentials provided',
        HttpStatus.BAD_REQUEST,
      );
  }

  async findAll() {
    return await this.dosenRepository.find();
  }

  async findOneByUsername(username: string) {
    return await this.dosenRepository.findOneBy({ username });
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
