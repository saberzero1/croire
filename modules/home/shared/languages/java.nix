{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maven
    gradle
    jdk
    jre
  ];
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
  };
  home.shellAliases = {
    javac = "${pkgs.jdk}/bin/javac";
    java = "${pkgs.jdk}/bin/java";
  };
}
