import { IsString, IsNotEmpty, MinLength } from 'class-validator';

export class CreateDosenDto {
  @IsString()
  @IsNotEmpty()
  username: string;

  @IsString()
  @IsNotEmpty()
  password: string;
}
