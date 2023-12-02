import { IsNotEmpty, MinLength, IsNumberString } from 'class-validator';

export class OTP_DTO {
  @IsNumberString()
  @IsNotEmpty()
  mahasiswa_id: number;

  @IsNumberString()
  @IsNotEmpty()
  otp: number;
}
