import { IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class LoginDto {
  @IsNotEmpty()
  @ApiProperty({
    description: '账号',
    default: 'admin',
  })
  readonly username: string;

  @IsNotEmpty()
  @ApiProperty({
    description: '密码',
    default: 'admin',
  })
  readonly password: string;
}