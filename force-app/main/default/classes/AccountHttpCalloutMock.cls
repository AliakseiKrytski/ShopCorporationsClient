@isTest
public class AccountHttpCalloutMock implements HttpCalloutMock {
    public static final Id MOCK_TEST_ACCOUNT_ID = (Id)'0012w00000K5RDjAAN';
    
    public HTTPResponse respond(HTTPRequest request) {
        switch on request.getMethod() {
            when 'GET' {
                return respondGet(request);
            }
            when 'POST' {
                return respondPost(request);
            }
            when 'DELETE' {
                return respondDelete(request);
            }
            when 'UPSERT' {
                return respondUpsert(request);
            }
            when 'UPDATE' {
                return respondUpdate(request);
            }
            when else {
                return new HttpResponse();
            }
        }
    }

    private HttpResponse respondGet(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"Id": "0012w00000K5RDjAAN", "Name": "Account1", "Type": "Prospect", "AccountNumber": "468464", "Website": "https://trailhead.salesforce.com", "Phone": "4654789"}');
        response.setStatusCode(200);
        return response;
    }

    private HttpResponse respondPost(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(MOCK_TEST_ACCOUNT_ID);
        response.setStatusCode(200);
        return response;
    }

    private HttpResponse respondDelete(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(MOCK_TEST_ACCOUNT_ID);
        response.setStatusCode(200);
        return response;
    }

    private HttpResponse respondUpsert(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(MOCK_TEST_ACCOUNT_ID);
        response.setStatusCode(200);
        return response;
    }

    private HttpResponse respondUpdate(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(MOCK_TEST_ACCOUNT_ID);
        response.setStatusCode(200);
        return response;
    }
}
