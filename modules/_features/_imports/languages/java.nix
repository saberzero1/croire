{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      maven
      gradle
      jdk
      jre
    ];
    sessionVariables = {
      JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    };
    shellAliases = {
      javac = "${pkgs.jdk}/bin/javac";
      java = "${pkgs.jdk}/bin/java";
    };
  };
}
