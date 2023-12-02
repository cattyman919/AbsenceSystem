import { Kelas } from 'src/kelas/entities/kelas.entity';
import { Mahasiswa } from 'src/mahasiswa/entities/mahasiswa.entity';
import {
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  Entity,
  JoinColumn,
} from 'typeorm';

@Entity('absensi')
export class Absensi {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  waktu_masuk: string;

  @Column()
  waktu_keluar: boolean;

  @ManyToOne(() => Kelas, (kelas) => kelas.absensi)
  @JoinColumn({ name: 'kelas' })
  kelas: Kelas;

  @ManyToOne(() => Mahasiswa, (mahasiswa) => mahasiswa.absensi)
  @JoinColumn({ name: 'mahasiswa' })
  mahasiswa: Mahasiswa;
}
