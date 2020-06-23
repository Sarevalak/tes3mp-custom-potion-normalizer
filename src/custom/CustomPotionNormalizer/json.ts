// tslint:disable-next-line: no-var-requires
const dkjson = require('dkjson');

export const JSON = {
    parse: (json: string): any => {
        return dkjson.decode(json);
    },
    stringify: (obj: any, cd: any = null, i?: number): string => {
        return dkjson.encode(obj, { indent: true, keyorder: null });
    }
};
