import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MahasiswaService } from './mahasiswa.service';
import { CreateMahasiswaDto } from './dto/create-mahasiswa.dto';
import { UpdateMahasiswaDto } from './dto/update-mahasiswa.dto';

@Controller('mahasiswa')
export class MahasiswaController {
  constructor(private readonly mahasiswaService: MahasiswaService) {}

  @Post()
  create(@Body() createMahasiswaDto: CreateMahasiswaDto) {
    return this.mahasiswaService.create(createMahasiswaDto);
  }

  @Get()
  findAll() {
    return this.mahasiswaService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.mahasiswaService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateMahasiswaDto: UpdateMahasiswaDto) {
    return this.mahasiswaService.update(+id, updateMahasiswaDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.mahasiswaService.remove(+id);
  }
}
