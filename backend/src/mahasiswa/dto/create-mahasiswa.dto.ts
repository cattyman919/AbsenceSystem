import { Type } from 'class-transformer';
import {
  IsArray,
  IsNotEmpty,
  IsNumber,
  IsNumberString,
  IsString,
} from 'class-validator';

export class CreateMahasiswaDto {
  @IsString()
  @IsNotEmpty()
  nama: string;

  @IsString()
  @IsNotEmpty()
  npm: string;

  @IsString()
  @IsNotEmpty()
  rfid_tag: string;

  @IsNumberString()
  @IsNotEmpty()
  otp: number;

  @IsNotEmpty()
  kelasIds: number[];
}
