import { Absensi } from 'src/absensi/entities/absensi.entity';
import { PrimaryGeneratedColumn, Column, OneToMany, Entity } from 'typeorm';

@Entity('kelas')
export class Kelas {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 255 })
  nama: string;

  @OneToMany(() => Absensi, (absensi) => absensi.kelas)
  absensi: Absensi[];
}
