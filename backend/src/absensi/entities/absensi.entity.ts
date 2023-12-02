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

  @Column('timestamp')
  waktu_masuk: string;

  @Column('timestamp')
  waktu_keluar: string;

  @Column()
  minggu_ke: number;

  @ManyToOne(() => Kelas, (kelas) => kelas.absensi, { eager: true })
  @JoinColumn({ name: 'kelas_id' })
  kelas: Kelas;

  @ManyToOne(() => Mahasiswa, (mahasiswa) => mahasiswa.absensi, { eager: true })
  @JoinColumn({ name: 'mahasiswa_id' })
  mahasiswa: Mahasiswa;
}
