import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response } from 'express';
import { Logger } from '../utils/log4js';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
    use(req: Request, res: Response, next: Function) {
        const code = res.statusCode; // 响应状态码
        const header=res.getHeaders()
        next();
        // 组装日志信息
        const logFormat = `header:${JSON.stringify(header)} \n Method: ${req.method} \n Request original url: ${req.originalUrl} \n baseUrl: ${req.baseUrl} \n IP: ${req.ip} \n host: ${req.host} \n hostname: ${req.hostname} \n Status code: ${code} \n params:${JSON.stringify(req.params)}\n query:${JSON.stringify(req.query)} \n body:${JSON.stringify(req.body)}`;
        // 根据状态码，进行日志类型区分
        if (code >= 500) {
            Logger.error(logFormat);
        } else if (code >= 400) {
            Logger.warn(logFormat);
        } else {
            Logger.access(logFormat);
            Logger.log(logFormat);
        }
    }

}
