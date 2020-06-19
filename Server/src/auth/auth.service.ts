import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { LoginDto } from './dto/login.dto';
import { UserService } from 'src/user/user.service';
import { UserEntity } from 'src/user/user.entity';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService
  ) { }

  //   async validateUser(username: string, pass: string): Promise<any> {
  //     const user = await this.userService.findOne(username);
  //     if (user && user.password === pass) {
  //       const { password, ...result } = user;
  //       return result;
  //     }
  //     return null;
  //   }

  async createToken(user: LoginDto) {
    const { username, password } = user;
    const entity: UserEntity = await this.userService.findByName(username);

    if (!entity) {
      throw new UnauthorizedException('用户名不存在。');
    }

    if (!(await entity.comparePassword(password))) {
      throw new UnauthorizedException('密码不匹配。');
    }
    const { id } = entity;

    const payload = { username: user.username, userId: id };
    return {
      // code: "123",
      data: {
        access_token: this.jwtService.sign(payload),
      }
    };
  }
}
