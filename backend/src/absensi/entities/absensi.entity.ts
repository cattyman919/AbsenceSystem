import { Kelas } from 'src/kelas/entities/kelas.entity';
import { Mahasiswa } from 'src/mahasiswa/entities/mahasiswa.entity';
import {
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  Entity,
  JoinColumn,
  CreateDateColumn,
} from 'typeorm';

@Entity('absensi')
export class Absensi {
  @PrimaryGeneratedColumn()
  id: number;

  @CreateDateColumn({ name: 'waktu_masuk', type: 'timestamptz' })
  waktu_masuk: Date;

  @Column('timestamptz')
  waktu_keluar: Date;

  @Column({ name: 'minggu_ke', default: 1, nullable: false })
  minggu_ke: number;

  @ManyToOne(() => Kelas, (kelas) => kelas.absensi, {
    eager: true,
    onUpdate: 'CASCADE',
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'kelas_id' })
  kelas: Kelas;

  @ManyToOne(() => Mahasiswa, (mahasiswa) => mahasiswa.absensi, {
    eager: true,
    onUpdate: 'CASCADE',
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'mahasiswa_id' })
  mahasiswa: Mahasiswa;
}
