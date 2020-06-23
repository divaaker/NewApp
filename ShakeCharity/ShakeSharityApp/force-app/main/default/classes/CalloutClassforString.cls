public class CalloutClassforString {
    public static HttpResponse getInfoFromExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://3k0fpzhw53.execute-api.us-east-2.amazonaws.com/Pro/charitydata/AMERICAN');
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }
}