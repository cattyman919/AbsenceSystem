import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { DosenService } from './dosen.service';
import { CreateDosenDto } from './dto/create-dosen.dto';
import { UpdateDosenDto } from './dto/update-dosen.dto';

@Controller('dosen')
export class DosenController {
  constructor(private readonly dosenService: DosenService) {}

  @Post()
  create(@Body() createDosenDto: CreateDosenDto) {
    return this.dosenService.create(createDosenDto);
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
