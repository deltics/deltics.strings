
  unit Uri.Tests;

interface

  uses
    Deltics.Smoketest,
    Deltics.Uri;


  type
    UriComponents = record
      Scheme: String;
      UserInfo: String;
      Host: String;
      Port: Integer;
      Path: String;
      Query: String;
      Fragment: String;
      constructor Init(const aScheme: String; const aUserInfo: String; const aHost: String; const aPort: Integer; const aPath: String; const aQuery: String; const aFragment: String);
    end;


    TUriTests = class(TTestCase)
    private
      procedure TestComponents(const aUriString: String; const aComponents: UriComponents);
    published
      procedure UriComponentsAreCorrectlyIdentifiedInStrings;
    end;



implementation



  constructor UriComponents.Init(const aScheme: String;
                                 const aUserInfo: String;
                                 const aHost: String;
                                 const aPort: Integer;
                                 const aPath: String;
                                 const aQuery: String;
                                 const aFragment: String);
  begin
    Scheme    := aScheme;
    UserInfo  := aUserInfo;
    Host      := aHost;
    Port      := aPort;
    Path      := aPath;
    Query     := aQuery;
    Fragment  := aFragment;
  end;


  procedure TUriTests.TestComponents(const aUriString: String; const aComponents: UriComponents);
  var
    uri: TUri;
  begin
    uri := TUri.Create(aUriString);
    try
      Note(aUriString);
      Test['Scheme'].Expect(uri.Scheme).Equals(aComponents.Scheme);
      Test['UserInfo'].Expect(uri.UserInfo).Equals(aComponents.UserInfo);
      Test['Host'].Expect(uri.Host).Equals(aComponents.Host);
      Test['Port'].Expect(uri.Port).Equals(aComponents.Port);
      Test['Path'].Expect(uri.Path).Equals(aComponents.Path);
      Test['Query'].Expect(uri.Query).Equals(aComponents.Query);
      Test['Fragment'].Expect(uri.Fragment).Equals(aComponents.Fragment);

    finally
      uri.Free;
    end;
  end;


  procedure TUriTests.UriComponentsAreCorrectlyIdentifiedInStrings;
  begin
    TestComponents('file:///c:/folder/subfolder', UriComponents.Init('file', '', '', -1, 'c:/folder/subfolder', '',''));
    TestComponents('c:\duget\whatever',           UriComponents.Init('file', '', '', -1, 'c:/duget/whatever', '',''));

    TestComponents('http://api.duget.org/v1/index.json',                                UriComponents.Init('http', '',      'api.duget.org', -1, 'v1/index.json', '',''));
    TestComponents('http://user@hostname:443/api.duget.org/v1/index.json?latest#frag',  UriComponents.Init('http', 'user',  'hostname',     443, 'api.duget.org/v1/index.json', 'latest','frag'));
    TestComponents('https://hostname:443/api.duget.org/v1/index.json?latest#frag',      UriComponents.Init('https', '',     'hostname',     443, 'api.duget.org/v1/index.json', 'latest','frag'));
    TestComponents('https://user@hostname/api.duget.org/v1/index.json?latest#frag',     UriComponents.Init('https', 'user', 'hostname',      -1, 'api.duget.org/v1/index.json', 'latest','frag'));
  end;





initialization
  Smoketest.Add(TUriTests);
end.
