import { PartialType } from '@nestjs/mapped-types';
import { CreateMahasiswaDto } from './create-mahasiswa.dto';

export class UpdateMahasiswaDto extends PartialType(CreateMahasiswaDto) {}
