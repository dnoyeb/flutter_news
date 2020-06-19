import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, getRepository, DeleteResult } from 'typeorm';
import { CreateUserDto } from './dto/create-user.dto';
import { UserEntity } from './user.entity';
import { validate } from 'class-validator';
import { UserRO } from './user.interface';
import { UpdateUserDto } from './dto/update-user.dto';
@Injectable()
export class UserService {
    constructor(
        @InjectRepository(UserEntity)
        private readonly userRepository: Repository<UserEntity>
    ) { }

    async create(dto: CreateUserDto): Promise<UserRO> {
        // check uniqueness of username/email
        const { username, password } = dto;
        const qb = await getRepository(UserEntity)
            .createQueryBuilder('user')
            .where('user.username = :username', { username })

        const user = await qb.getOne();

        if (user) {
            const errors = { username: 'Username and email must be unique.' };
            throw new HttpException({ message: 'Input data validation failed', errors }, HttpStatus.BAD_REQUEST);

        }

        // create new user
        let newUser = new UserEntity();
        newUser.username = username;
        newUser.password = password;

        const errors = await validate(newUser);
        if (errors.length > 0) {
            const _errors = { username: 'Userinput is not valid.' };
            throw new HttpException({ message: 'Input data validation failed', _errors }, HttpStatus.BAD_REQUEST);

        } else {
            const savedUser = await this.userRepository.save(newUser);
            return this.buildUserRO(savedUser);
        }

    }
    private buildUserRO(user: UserEntity) {
        const userRO = {
            userId: user.id,
            username: user.username,
        };

        return { user: userRO };
    }

    async findOne(id: number) {
        const user = await getRepository(UserEntity).findOne(id);

        return user || { user: null }

    }

    async findByName(username: string) {
        return await getRepository(UserEntity).findOne({ username });
    }

    async delete(id: number): Promise<DeleteResult> {
        return await this.userRepository.delete({ id });
    }

    async update(userData: UpdateUserDto): Promise<UserEntity> {
        let toUpdate = await this.userRepository.findOne(userData.userId);
        delete toUpdate.password;

        let updated = Object.assign(toUpdate, userData);
        return this.userRepository.save(updated);
    }
}
