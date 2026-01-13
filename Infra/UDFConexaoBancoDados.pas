unit UDFConexaoBancoDados;

Interface

uses
  IniFiles, SysUtils, Forms, FireDAC.Comp.Client, Dialogs, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef;

const
  Secao = 'Conexao';

type
  TConexao = class
  private
    FCaminho: string;
    FServidor: string;
    FPorta: integer;
    FDatabase: string;
    FSenha: string;
    FUsuario: string;
    FDriver: string;
  public
    constructor Create(Path: string);
    procedure LerINI(); virtual;
    procedure GravarINI(Usuario, Senha, Servidor, Banco: string); virtual;
    procedure ConfigurarParametros(Conexao: TFDConnection);

    property Caminho: string read FCaminho write FCaminho;
    property Servidor: string read FServidor write FServidor;
    property Porta: integer read FPorta write FPorta;
    property Database: string read FDatabase write FDatabase;
    property Senha: string read FSenha write FSenha;
    property Usuario: string read FUsuario write FUsuario;
    property Driver: string read FDriver write FDriver;

  end;

implementation

procedure TConexao.ConfigurarParametros(Conexao: TFDConnection);
begin
  LerINI();

  Conexao.Connected := False;
  Conexao.LoginPrompt := False;

  Conexao.Params.Values['DriverID'] := 'FB';
  Conexao.Params.Values['User_Name'] := Usuario;
  Conexao.Params.Values['Password']  := Senha;
  Conexao.Params.Values['Database']  := Database;

  Conexao.Params.Values['Protocol'] := 'TCPIP';
  Conexao.Params.Values['Server']   := 'localhost';
  Conexao.Params.Values['Port']     := '3050';
end;

constructor TConexao.Create(Path: string);
begin
  Self.Caminho := Path;
end;

procedure TConexao.GravarINI(Usuario, Senha, Servidor, Banco: string);
var
  LArqIni: TIniFile;
begin
  LArqIni := TIniFile.Create(Caminho);
  try
    LArqIni.WriteString(Secao, 'Usuario', Usuario);
    LArqIni.WriteString(Secao, 'Senha', Senha);
    LArqIni.WriteString(Secao, 'Database', Banco);
  finally
    LArqIni.Free;
  end;
end;

procedure TConexao.LerINI();
var
  LArqIni: TIniFile;
begin
  LArqIni := TIniFile.Create(Caminho);
  try
    Database := LArqIni.ReadString(Secao, 'Database', '');
    Senha := LArqIni.ReadString(Secao, 'Senha', '');
    Usuario := LArqIni.ReadString(Secao, 'Usuario', '');

  finally
    LArqIni.Free;
  end;
end;

end.
