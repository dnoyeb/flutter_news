import { Controller, Body, UsePipes, Post, Get, Delete, Param, Put, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { UpdateUserDto } from './dto/update-user.dto';
// import { AuthGuard } from '@nestjs/passport';
import { AuthService } from '../auth/auth.service';
import { AuthGuard } from '@nestjs/passport';
import { ValidationPipe } from 'src/pipe/validation.pipe';

@ApiTags('用户接口')
@Controller('user')
export class UserController {
    constructor(
        private readonly userService: UserService,
        private readonly authService: AuthService,
    ) { }

    // @UsePipes(new ValidationPipe())
    @Post('createUser')
    async create(@Body() userData: CreateUserDto) {
        return this.userService.create(userData);

    }

    // @ApiBearerAuth()
    // @UseGuards(AuthGuard('jwt'))
    @Get(':id')
    async findOne(@Param('id') id: number) {
        return this.userService.findOne(id);

    }

    @Delete(':id')
    async delete(@Param('id') id: number) {
        return await this.userService.delete(id);
    }

    // @UsePipes(new ValidationPipe())
    @Put()
    async update(@Body() userData: UpdateUserDto) {
        return await this.userService.update(userData);
    }

}
