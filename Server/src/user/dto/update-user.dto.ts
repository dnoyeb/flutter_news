import { IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateUserDto {
  @IsNotEmpty()
  @ApiProperty({
    description: '修改账号',
    default: 'admin',
  })
  readonly username: string;
  @IsNotEmpty()
  @ApiProperty({
    description: '账号ID',
    default: '123',
  })
  readonly userId: string;
}