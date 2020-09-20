public with sharing class AccountCallouts {
    private static final String WEB_SERVICE_URL = 'callout:ShopCorporations_WebService_Credential';
    

    public static Account makeGetAccountByIdCallout(Id accountId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WEB_SERVICE_URL + '/' + accountId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            return getAccountFromJsonResponse(response);
        } else {
            throw new System.CalloutException('Request failed with status code ' + response.getStatusCode() + ': ' + response.getStatus());
        }
    }

    public static Id makeCreateAccountCallout(Account newAccount) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WEB_SERVICE_URL);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(getAccountJson(newAccount));
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Id newAccountId = (Id) JSON.deserializeUntyped(response.getBody());
            System.debug('New account was successfully created with ID ' + newAccountId);
            return newAccountId;
        } else {
            throw new System.CalloutException('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        }
    }

    public static void makeDeleteAccountCallout(Id accountId) {  
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WEB_SERVICE_URL + '/' + accountId);
        request.setMethod('DELETE');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            System.debug('Account with ID ' + accountId + ' was successfully deleted');
        } else {
            throw new System.CalloutException('Request failed with status code ' + response.getStatusCode() + ': ' + response.getStatus());
        }
    }

    public static Id makeUpsertAccountCallout(Account changedAccount) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WEB_SERVICE_URL);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(getAccountJson(changedAccount));
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Id upsertedAccountId = (Id) JSON.deserializeUntyped(response.getBody());
            System.debug('Account with ID ' + upsertedAccountId + ' was successfully upserted.');
            return upsertedAccountId;
        } else {
            throw new System.CalloutException('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        }
    }

    public static Id makeUpdateAccountCallout(Account changedAccount) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WEB_SERVICE_URL + '/' + changedAccount.Id);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(getAccountJson(changedAccount));
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Id updatedAccountId = (Id) JSON.deserializeUntyped(response.getBody());
            System.debug('Account with ID ' + updatedAccountId + ' was successfully updated.');
            return updatedAccountId;
        } else {
            throw new System.CalloutException('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        }
    }

    
    private static Account getAccountFromJsonResponse(HttpResponse response) {
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        return new Account(
                					Id=(Id)result.get('Id'),
            						Name=(String)result.get('Name'),
            						Type=(String)result.get('Type'),
                                    AccountNumber=(String)result.get('AccountNumber'),
                                    Website=(String)result.get('Website'),
                                    Phone=(String)result.get('Phone'));
    }

    private static String getAccountJson(Account account) {  
        Map<String, Object> params = new Map<String, Object>();
        putParamIfNotNull(params, 'Id', account.Id);
        putParamIfNotNull(params, 'Name', account.Name);
        putParamIfNotNull(params, 'Type', account.Type);
        putParamIfNotNull(params, 'AccountNumber', account.AccountNumber);
        putParamIfNotNull(params, 'Website', account.Website);
        putParamIfNotNull(params, 'Phone', account.Phone);
        return JSON.serialize(params);
    }
    
    private static void putParamIfNotNull(Map<String, Object> params, String key, Object value) {
        if (value != null) {
            params.put(key, value);
        }
    }
}