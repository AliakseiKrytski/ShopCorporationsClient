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
            when 'PUT' {
                return respondUpsert(request);
            }
            when 'PATCH' {
                return respondUpdate(request);
            }
            when else {
                return new HttpResponse();
            }
        }
    }

    private HttpResponse respondGet(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        Id accountId = (Id) request.getEndpoint().substring(request.getEndpoint().lastIndexOf('/')+1);
        if (accountId == MOCK_TEST_ACCOUNT_ID) {
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"Id": "0012w00000K5RDjAAN", "Name": "Account1", "Type": "Prospect", "AccountNumber": "468464", "Website": "https://trailhead.salesforce.com", "Phone": "4654789"}');
            response.setStatusCode(200);
        } else {
            response.setStatusCode(404);
        }
        
        return response;
    }

    private HttpResponse respondPost(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.getBody());
        if (params.keySet().equals(new Set<String> { 'Name', 'Type', 'AccountNumber', 'Website', 'Phone' })) {
            response.setHeader('Content-Type', 'application/json');
            response.setBody(MOCK_TEST_ACCOUNT_ID);
            response.setStatusCode(200);
        } else {
            response.setStatusCode(400);
        }
        return response;
    }

    private HttpResponse respondDelete(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        Id accountId = (Id) request.getEndpoint().substring(request.getEndpoint().lastIndexOf('/')+1);
        System.assertEquals(MOCK_TEST_ACCOUNT_ID, accountId);
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        return response;
    }

    private HttpResponse respondUpsert(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.getBody());
        Id accountId = (Id) params.get('Id');
        Set<String> allAvailableFields = new Set<String> { 'Id', 'Name', 'Type', 'AccountNumber', 'Website', 'Phone' };
        if (accountId == MOCK_TEST_ACCOUNT_ID) {
            if (allAvailableFields.containsAll(params.keySet())) {
                response.setHeader('Content-Type', 'application/json');
                response.setBody(accountId);
                response.setStatusCode(200);
            } else {
                response.setStatusCode(400);
            }
        } else {
            if (params.keySet().equals(allAvailableFields)) {
                response.setHeader('Content-Type', 'application/json');
                response.setBody(accountId);
                response.setStatusCode(200);
            } else {
                response.setStatusCode(400);
            }
        }
        return response;
    }

    private HttpResponse respondUpdate(HTTPRequest request) {
        Set<String> allAvailableFields = new Set<String> { 'Id', 'Name', 'Type', 'AccountNumber', 'Website', 'Phone' };
        HttpResponse response = new HttpResponse();
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.getBody());
        Id accountId = (Id) request.getEndpoint().substring(request.getEndpoint().lastIndexOf('/')+1);
        if (accountId == MOCK_TEST_ACCOUNT_ID) {
            if (allAvailableFields.containsAll(params.keySet())) {
                response.setHeader('Content-Type', 'application/json');
                response.setBody(accountId);
                response.setStatusCode(200);
            } else {
                response.setStatusCode(400);
            }
        } else {
            response.setStatusCode(404);
        }
        return response;
    }
}
