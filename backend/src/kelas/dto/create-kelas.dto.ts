import { IsNotEmpty, IsString } from 'class-validator';

export class CreateKelasDto {
    @IsString()
    @IsNotEmpty()
    nama: string;
}
