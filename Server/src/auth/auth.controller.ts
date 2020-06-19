import { Controller, Post, Body, UseGuards, Get, Query, Request } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
// import { AuthGuard } from '@nestjs/passport';
import { ApiTags, ApiBearerAuth, ApiHeaders} from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';

@ApiTags('Auth接口')
@Controller('auth')
export class AuthController {
    constructor(
        private readonly authService: AuthService
    ) { }

    @Post('login')
    async login(@Body() user: LoginDto) {
        return await this.authService.createToken(user);
    }

    // @ApiHeaders([{
    //     name:'Authorization'
    // }])
    @ApiBearerAuth()
    @UseGuards(AuthGuard('jwt'))
    @Get('profile')
    getProfile(@Request() req) {
        return req.user;
    }
}