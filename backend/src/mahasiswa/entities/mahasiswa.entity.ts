import { Absensi } from 'src/absensi/entities/absensi.entity';
import { Kelas } from 'src/kelas/entities/kelas.entity';
import {
  PrimaryGeneratedColumn,
  Column,
  OneToMany,
  Entity,
  ManyToMany,
  JoinTable,
} from 'typeorm';

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

  @OneToMany(() => Absensi, (absensi) => absensi.mahasiswa)
  absensi: Absensi[];

  @ManyToMany(() => Kelas)
  @JoinTable({
    name: 'enrollment', // Nama tabel perantara
    joinColumn: {
      name: 'id_mahasiswa',
      referencedColumnName: 'id',
    },
    inverseJoinColumn: {
      name: 'id_kelas',
      referencedColumnName: 'id',
    },
  })
  kelas: Kelas[];
}
