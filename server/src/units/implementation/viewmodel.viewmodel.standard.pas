unit ViewModel.ViewModel.Standard;

interface
uses
  cwCollections
, ViewModel
, DataModel
;

type
  TViewModel = class( TInterfacedObject, IViewModel )
  private
    fDataModel: IDataModel;
  strict private
    function getPublicGames: string;
    function CreateGame( const json: string ): string;
  private
    function ListToJSON( const value: IList<IGameObject> ): string;
  public
    constructor Create( DataModel: IDataModel ); reintroduce;
  end;

implementation
uses
  StrUtils
, SysUtils
, cwCollections.Standard
, ViewModel.Game.Standard
, DataModel.GameData.Standard
, System.JSON
, REST.JSON
;

{ TViewModel }

constructor TViewModel.Create(DataModel: IDataModel);
begin
  inherited Create;
  fDataModel := DataModel;
end;

function TViewModel.CreateGame(const json: string): string;
var
  Request: TJSONObject;
  SessionName: string;
  LangID: string;
  IsPrivate: boolean;
  NewGameData: IGameData;
  NewGame: IGame;
begin
  Request := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(json),0) as TJSONObject;
  SessionName := Request.GetValue('SessionName').Value;
  LangId := Request.GetValue('LangID').Value;
  IsPrivate := Uppercase(Request.GetValue('IsPrivate').Value) = 'TRUE';
  NewGameData := TGameData.Create(SessionName,LangID,IsPrivate);
  NewGame := TGame.Create(NewGameData);
  Result := NewGame.ToJSON;
end;

function TViewModel.getPublicGames: string;
var
  GameData: IList<IGameData>;
  PublicGames: IList<IGameObject>;
begin
  PublicGames := TList<IGameObject>.Create;
  GameData := fDataModel.getGames;
  if GameData.Count>0 then begin
    GameData.ForEach(
      procedure ( const Item: IGameData )
      begin
        PublicGames.Add( TGame.Create(Item) );
      end
    );
  end;
  Result := ListToJSON(PublicGames);
end;

function TViewModel.ListToJSON(const value: IList<IGameObject>): string;
var
  _Result: string;
begin
  Result := '[]';
  _Result := '';
  if Value.Count=0 then begin
    exit;
  end;
  try
    _Result := '[';
    Value.ForEach(
      procedure( const item: IGameObject )
      begin
        _Result := _Result + Item.ToJSON;
        _Result := _Result + ',';
      end
    );
    _Result := LeftStr(_Result,pred(Length(_Result)));
    _Result := _Result + ']';
  finally
    Result := _Result;
  end;
end;

end.
