import fetch from 'node-fetch';

class SDKReqError extends Error {
    response: any;
    constructor(m: string, response: any) {
        super(m);
        this.response = response;

        // Set the prototype explicitly.
        Object.setPrototypeOf(this, SDKReqError.prototype);
    }
}

const check = (response: any) => {
    if (response.status >= 200 && response.status < 300) {
        return response;
    }

    throw new SDKReqError(response.statusText, response);
};

const parseJSON = (response: any) => {
    return response.text().then((body: string) => {
        if (body) {
            return JSON.parse(body);
        }
        return body;
    });
};

export function request(url: string, method: string, headers: any, payload: object) {
    const options = {
        method,
        body: method === 'GET' ? null : JSON.stringify(payload),
        headers: {
            'Content-type': 'application/json',
            ...headers,
        },
    };
    return fetch(url, options).then(check).then(parseJSON);
}
