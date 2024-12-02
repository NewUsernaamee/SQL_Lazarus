unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, mysql80conn, SQLDB;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    MySQL80Connection1: TMySQL80Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
    procedure MySQL80Connection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.MySQL80Connection1AfterConnect(Sender: TObject);
begin

end;

end.

