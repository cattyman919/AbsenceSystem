import { Absensi } from 'src/absensi/entities/absensi.entity';
import { PrimaryGeneratedColumn, Column, OneToMany, Entity } from 'typeorm';

@Entity('mahasiswa')
export class Mahasiswa {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 255, nullable: true })
  nama: string;

  @Column({ length: 100, nullable: true, unique: true })
  npm: string;

  @Column({ length: 100, nullable: true, unique: true })
  rfid_tag: string;

  @Column({ length: 100, nullable: true, unique: true })
  otp: string;

  @OneToMany(() => Absensi, (absensi) => absensi.mahasiswa)
  absensi: Absensi[];
}
