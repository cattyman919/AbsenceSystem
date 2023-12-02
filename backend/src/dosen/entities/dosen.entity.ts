import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity('dosen')
export class Dosen {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 200, unique: true })
  username: string;

  @Column({ length: 200 })
  password: string;
}
