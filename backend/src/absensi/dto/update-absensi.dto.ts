import { PartialType } from '@nestjs/mapped-types';
import { CreateAbsensiDto } from './create-absensi.dto';

export class UpdateAbsensiDto extends PartialType(CreateAbsensiDto) {}
