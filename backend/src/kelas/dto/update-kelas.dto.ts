import { PartialType } from '@nestjs/mapped-types';
import { CreateKelasDto } from './create-kelas.dto';

export class UpdateKelasDto extends PartialType(CreateKelasDto) {}
