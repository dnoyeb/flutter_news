import { Injectable, NestInterceptor, ExecutionContext, CallHandler, BadGatewayException } from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable()
export class ResponseInterceptor implements NestInterceptor {
    intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
        // const ctx = context.switchToHttp()

        return next
            .handle()
            .pipe(
                map(data => Object.assign({
                    code: 'A000000',
                    timestamp: new Date().toISOString(),
                    message: '请求成功'
                }, data)),
            );
    }
}
