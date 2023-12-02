import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
  HttpCode,
} from '@nestjs/common';
import { Request } from 'express';
import { DosenService } from './dosen.service';
import { CreateDosenDto } from './dto/create-dosen.dto';
import { UpdateDosenDto } from './dto/update-dosen.dto';

@Controller('dosen')
export class DosenController {
  constructor(private readonly dosenService: DosenService) {}

  @Post('register')
  async register(@Body() createDosenDto: CreateDosenDto) {
    const createdDosen = await this.dosenService.register(createDosenDto);
    if (createdDosen)
      return {
        username: createdDosen.username,
        message: 'Account has been successfuly created',
      };
  }

  @Post('login')
  async login(@Body() createDosenDto: CreateDosenDto) {
    const dosen = await this.dosenService.login(createDosenDto);
    if (dosen)
      return {
        username: dosen.username,
        message: 'Login successful',
      };
  }

  @Get('profile')
  profile(@Req() request: Request) {
    console.log(request.session);
    console.log(request.sessionID);
    return {
      session: request.session,
      sessionID: request.sessionID,
    };
  }

  @Get()
  findAll() {
    return this.dosenService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.dosenService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateDosenDto: UpdateDosenDto) {
    return this.dosenService.update(+id, updateDosenDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.dosenService.remove(+id);
  }
}
