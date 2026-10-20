{
  lib,
  stdenvNoCC,
  fetchurl,
  perl,
  gcc,
  flex,
  bison,
  happy,
  ghc,
  gmp,
  bootstrap,
  bash,
}:

stdenvNoCC.mkDerivation (
  finalAttrs:
  let
    interpreter = false;
  in
  {
    pname = "ghc${lib.strings.optionalString (bootstrap == 0) "-hc"}";
    version = "4.02";
    src = fetchurl {
      url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-src.tar.gz";
      hash = "sha256-KeNUkV5ecjlmzyNm/hsWRoaS3G1oSl9wel8xmoHN/ZU=";
    };
    postUnpack = lib.strings.optionalString (bootstrap == 0) ''
      tar xf ${
        fetchurl {
          url = "https://downloads.haskell.org/~ghc/${finalAttrs.version}/ghc-${finalAttrs.version}-x86-hc.tar.gz";
          hash = "sha256-MhG9i50O8cCKCh9kxRLptE08VoF6KC8e9h7EIdWnMLU=";
        }
      } -C fptools
    '';
    prePatch = lib.strings.optionalString (bootstrap == 2) ''
      for name in std exts
      do
          cp -r ghc/lib/$name ghc/lib/$name.bak
      done
    '';
    patches =
      lib.lists.optionals (bootstrap == 2) [
        ./boundeds.patch
        ./enums.patch
        ./foreignobj.patch
      ]
      ++ [ ./hsparser.patch ]
      ++ lib.lists.optionals (bootstrap == 1) [ ./modules.patch ]
      ++ lib.lists.optionals (bootstrap == 2) (
        [ ./integers.patch ]
        ++ lib.lists.optional (!interpreter) ./integers2.patch
        ++ [ ./monads.patch ]
        ++ lib.lists.optional (!interpreter) ./newtype.patch
        ++ [
          ./options.patch
          ./types.patch
        ]
      );
    postPatch = lib.strings.optionalString (bootstrap == 2) ''
      for name in std exts
      do
          mv ghc/lib/$name ghc/compiler/$name
          mv ghc/lib/$name.bak ghc/lib/$name
      done
    '';
    nativeBuildInputs = [
      perl
      gcc
      flex
      bison
      happy
    ]
    ++ lib.lists.optional (bootstrap != 0 && bootstrap != 2) ghc;
    configureFlags = lib.lists.optional (bootstrap == 0) (lib.strings.enableFeature true "hc-boot");
    preConfigure = ''
      export NIX_CFLAGS_COMPILE=
    '';
    buildPhase = ''
      runHook preBuild
    ''
    + (
      if bootstrap == 1 then
        ''
          make -C glafp-utils
          make -C ghc/utils
          make -C ghc/driver
          make -C ghc/includes
          make -C ghc/rts
          make -C ghc/docs
          make -C ghc/compiler
        ''
      else if bootstrap == 2 then
        ''
          make -C glafp-utils
          make -C ghc/utils
          make -C ghc/driver
          make -C ghc/includes
          make -C ghc/rts
          make -C ghc/docs
          cd ghc/compiler
          flex -o parser/hslexer.c parser/hslexer.flex
          bison -d -o parser/hsparser.tab.c parser/hsparser.y
          for name in std/cbits/*.c parser/*.c
          do
              ../driver/ghc -o $(echo $name | head -c-3).o -c $name
          done
          for name in */*.hs
          do
              ../driver/ghc -cpp -DHscIfaceFileVersion=5 -E $name > tmp
              mv tmp $name
          done
          for name in */*.lhs
          do
              ../driver/ghc -cpp -DHscIfaceFileVersion=5 -E $name > $(echo $name | head -c-5).hs
          done
        ''
        + (
          if interpreter then
            ""
          else
            ''
              cat std/PrelBase.hs std/PrelTup.hs std/Ix.hs std/PrelMaybe.hs std/PrelList.hs std/Monad.hs std/PrelST.hs std/PrelCCall.hs std/PrelAddr.hs std/PrelArr.hs std/Array.hs std/PrelNum.hs std/PrelPack.hs std/PrelIOBase.hs std/PrelDynamic.hs std/PrelException.hs std/PrelStable.hs std/PrelErr.hs std/Maybe.hs std/PrelNumExtra.hs std/PrelEither.hs std/PrelRead.hs std/PrelBounded.hs std/PrelForeign.hs std/PrelWeak.hs std/PrelHandle.hs std/Char.hs std/IO.hs std/Ratio.hs std/PrelConc.hs std/Prelude.hs std/Locale.hs std/Time.hs std/Directory.hs std/List.hs std/Numeric.hs std/PrelArrExtra.hs std/PrelMain.hs exts/CCall.hs exts/Bits.hs exts/Word.hs exts/Int.hs exts/Addr.hs exts/ByteArray.hs exts/IOExts.hs exts/ST.hs exts/MutableArray.hs exts/GlaExts.hs exts/Foreign.hs exts/NativeInfo.hs utils/PrimPacked.hs utils/FastString.hs utils/Panic.hs utils/Argv.hs main/Constants.hs utils/Maybes.hs main/CmdLineOpts.hs utils/Pretty.hs utils/Outputable.hs basicTypes/Unique.hs utils/UniqFM.hs utils/Util.hs utils/Bag.hs utils/FiniteMap.hs basicTypes/OccName.hs prelude/PrelMods.hs basicTypes/RdrName.hs basicTypes/SrcLoc.hs basicTypes/Name.hs parser/UgenUtil.hs parser/U_maybe.hs parser/U_list.hs parser/U_qid.hs parser/U_ttype.hs parser/U_constr.hs parser/U_binding.hs parser/U_either.hs parser/U_entidt.hs parser/U_grhsb.hs parser/U_match.hs parser/U_literal.hs parser/U_tree.hs parser/U_gdexp.hs utils/BitSet.hs utils/Digraph.hs utils/DirUtils.hs utils/ListSetOps.hs utils/OrdList.hs utils/SST.hs utils/StringBuffer.hs utils/UniqSet.hs basicTypes/BasicTypes.hs basicTypes/FieldLabel.hs basicTypes/Var.hs prelude/PrimRep.hs types/Class.hs types/TyCon.hs basicTypes/VarEnv.hs basicTypes/VarSet.hs basicTypes/NameSet.hs types/Type.hs prelude/TysPrim.hs basicTypes/DataCon.hs prelude/TysWiredIn.hs basicTypes/Demand.hs absCSyn/CallConv.hs profiling/CostCentre.hs basicTypes/PprEnv.hs types/PprType.hs prelude/PrimOp.hs absCSyn/CStrings.hs basicTypes/Const.hs types/Unify.hs specialise/SpecEnv.hs basicTypes/IdInfo.hs basicTypes/Id.hs coreSyn/CoreSyn.hs prelude/PrelVals.hs basicTypes/MkId.hs basicTypes/UniqSupply.hs hsSyn/HsBasic.hs hsSyn/HsTypes.hs coreSyn/PprCore.hs hsSyn/HsBinds.hs hsSyn/HsCore.hs hsSyn/HsPragmas.hs hsSyn/HsDecls.hs hsSyn/HsExpr.hs hsSyn/HsImpExp.hs hsSyn/HsMatches.hs hsSyn/HsPat.hs hsSyn/HsSyn.hs prelude/PrelInfo.hs reader/RdrHsSyn.hs rename/RnHsSyn.hs main/ErrUtils.hs rename/RnMonad.hs rename/RnEnv.hs rename/RnExpr.hs rename/RnBinds.hs rename/RnSource.hs reader/Lex.hs rename/ParseIface.hs rename/RnIfaces.hs rename/RnNames.hs rename/Rename.hs typecheck/TcMonad.hs typecheck/TcType.hs typecheck/TcEnv.hs typecheck/TcHsSyn.hs typecheck/Inst.hs typecheck/TcUnify.hs typecheck/TcSimplify.hs typecheck/TcMonoType.hs typecheck/TcPat.hs typecheck/TcBinds.hs simplCore/BinderInfo.hs coreSyn/CoreUtils.hs simplCore/OccurAnal.hs coreSyn/CoreUnfold.hs typecheck/TcClassDcl.hs typecheck/TcDefaults.hs typecheck/TcGenDeriv.hs typecheck/TcInstUtil.hs typecheck/TcDeriv.hs typecheck/TcMatches.hs typecheck/TcExpr.hs typecheck/TcForeign.hs coreSyn/CoreLint.hs stranal/WwLib.hs typecheck/TcIfaceSig.hs typecheck/TcInstDcls.hs typecheck/TcTyDecls.hs typecheck/TcTyClsDecls.hs typecheck/TcModule.hs deSugar/DsHsSyn.hs deSugar/DsMonad.hs deSugar/DsUtils.hs deSugar/Check.hs deSugar/DsGRHSs.hs deSugar/MatchCon.hs deSugar/MatchLit.hs deSugar/Match.hs deSugar/DsBinds.hs deSugar/DsCCall.hs deSugar/DsForeign.hs deSugar/DsListComp.hs deSugar/DsExpr.hs deSugar/Desugar.hs coreSyn/FreeVars.hs specialise/Specialise.hs simplCore/AnalFBWW.hs simplCore/SimplMonad.hs simplCore/ConFold.hs simplCore/FloatIn.hs simplCore/SetLevels.hs simplCore/FloatOut.hs simplCore/FoldrBuildWW.hs simplCore/LiberateCase.hs simplCore/MagicUFs.hs simplCore/SATMonad.hs simplCore/SAT.hs simplCore/SimplUtils.hs simplCore/Simplify.hs stranal/SaLib.hs stranal/SaAbsInt.hs stranal/WorkWrap.hs stranal/StrictAnal.hs simplCore/SimplCore.hs stgSyn/StgSyn.hs stgSyn/CoreToStg.hs stgSyn/StgLint.hs simplStg/LambdaLift.hs simplStg/SRT.hs profiling/SCCfinal.hs simplStg/StgStats.hs simplStg/StgVarInfo.hs simplStg/UpdAnal.hs simplStg/SimplStg.hs absCSyn/CLabel.hs absCSyn/AbsCSyn.hs absCSyn/AbsCUtils.hs codeGen/CgMonad.hs codeGen/CgUsages.hs codeGen/CgStackery.hs codeGen/CgRetConv.hs codeGen/SMRep.hs codeGen/ClosureInfo.hs codeGen/CgBindery.hs codeGen/CgUpdate.hs codeGen/CgHeapery.hs codeGen/CgClosure.hs codeGen/CgTailCall.hs codeGen/CgCon.hs codeGen/CgCase.hs codeGen/CgConTbls.hs codeGen/CgLetNoEscape.hs codeGen/CgExpr.hs codeGen/CodeGen.hs absCSyn/Costs.hs absCSyn/PprAbsC.hs parser/UgenAll.hs reader/PrefixSyn.hs reader/PrefixToHs.hs reader/ReadPrefix.hs main/MkIface.hs nativeGen/Stix.hs nativeGen/MachRegs.hs nativeGen/MachMisc.hs nativeGen/MachCode.hs nativeGen/PprMach.hs nativeGen/StixInfo.hs nativeGen/StixMacro.hs nativeGen/StixInteger.hs nativeGen/StixPrim.hs nativeGen/AbsCStixGen.hs nativeGen/RegAllocInfo.hs nativeGen/AsmRegAlloc.hs nativeGen/AsmCodeGen.hs main/Main.hs > main.hs
              i=0
              for name in std/PrelBase std/PrelTup std/Ix std/PrelMaybe std/PrelList std/Monad std/PrelST std/PrelCCall std/PrelAddr std/PrelArr std/Array std/PrelNum std/PrelPack std/PrelIOBase std/PrelDynamic std/PrelException std/PrelStable std/PrelErr std/Maybe std/PrelNumExtra std/PrelEither std/PrelRead std/PrelBounded std/PrelForeign std/PrelWeak std/PrelHandle std/Char std/IO std/Ratio std/PrelConc std/Prelude std/Locale std/Time std/Directory std/List std/Numeric std/PrelArrExtra std/PrelMain exts/CCall exts/Bits exts/Word exts/Int exts/Addr exts/ByteArray exts/IOExts exts/ST exts/MutableArray exts/GlaExts exts/Foreign exts/NativeInfo utils/PrimPacked utils/FastString utils/Panic utils/Argv main/Constants utils/Maybes main/CmdLineOpts utils/Pretty utils/Outputable basicTypes/Unique utils/UniqFM utils/Util utils/Bag utils/FiniteMap basicTypes/OccName prelude/PrelMods basicTypes/RdrName basicTypes/SrcLoc basicTypes/Name parser/UgenUtil parser/U_maybe parser/U_list parser/U_qid parser/U_ttype parser/U_constr parser/U_binding parser/U_either parser/U_entidt parser/U_grhsb parser/U_match parser/U_literal parser/U_tree parser/U_gdexp utils/BitSet utils/Digraph utils/DirUtils utils/ListSetOps utils/OrdList utils/SST utils/StringBuffer utils/UniqSet basicTypes/BasicTypes basicTypes/FieldLabel basicTypes/Var prelude/PrimRep types/Class types/TyCon basicTypes/VarEnv basicTypes/VarSet basicTypes/NameSet types/Type prelude/TysPrim basicTypes/DataCon prelude/TysWiredIn basicTypes/Demand absCSyn/CallConv profiling/CostCentre basicTypes/PprEnv types/PprType prelude/PrimOp absCSyn/CStrings basicTypes/Const types/Unify specialise/SpecEnv basicTypes/IdInfo basicTypes/Id coreSyn/CoreSyn prelude/PrelVals basicTypes/MkId basicTypes/UniqSupply hsSyn/HsBasic hsSyn/HsTypes coreSyn/PprCore hsSyn/HsBinds hsSyn/HsCore hsSyn/HsPragmas hsSyn/HsDecls hsSyn/HsExpr hsSyn/HsImpExp hsSyn/HsMatches hsSyn/HsPat hsSyn/HsSyn prelude/PrelInfo reader/RdrHsSyn rename/RnHsSyn main/ErrUtils rename/RnMonad rename/RnEnv rename/RnExpr rename/RnBinds rename/RnSource reader/Lex rename/ParseIface rename/RnIfaces rename/RnNames rename/Rename typecheck/TcMonad typecheck/TcType typecheck/TcEnv typecheck/TcHsSyn typecheck/Inst typecheck/TcUnify typecheck/TcSimplify typecheck/TcMonoType typecheck/TcPat typecheck/TcBinds simplCore/BinderInfo coreSyn/CoreUtils simplCore/OccurAnal coreSyn/CoreUnfold typecheck/TcClassDcl typecheck/TcDefaults typecheck/TcGenDeriv typecheck/TcInstUtil typecheck/TcDeriv typecheck/TcMatches typecheck/TcExpr typecheck/TcForeign coreSyn/CoreLint stranal/WwLib typecheck/TcIfaceSig typecheck/TcInstDcls typecheck/TcTyDecls typecheck/TcTyClsDecls typecheck/TcModule deSugar/DsHsSyn deSugar/DsMonad deSugar/DsUtils deSugar/Check deSugar/DsGRHSs deSugar/MatchCon deSugar/MatchLit deSugar/Match deSugar/DsBinds deSugar/DsCCall deSugar/DsForeign deSugar/DsListComp deSugar/DsExpr deSugar/Desugar coreSyn/FreeVars specialise/Specialise simplCore/AnalFBWW simplCore/SimplMonad simplCore/ConFold simplCore/FloatIn simplCore/SetLevels simplCore/FloatOut simplCore/FoldrBuildWW simplCore/LiberateCase simplCore/MagicUFs simplCore/SATMonad simplCore/SAT simplCore/SimplUtils simplCore/Simplify stranal/SaLib stranal/SaAbsInt stranal/WorkWrap stranal/StrictAnal simplCore/SimplCore stgSyn/StgSyn stgSyn/CoreToStg stgSyn/StgLint simplStg/LambdaLift simplStg/SRT profiling/SCCfinal simplStg/StgStats simplStg/StgVarInfo simplStg/UpdAnal simplStg/SimplStg absCSyn/CLabel absCSyn/AbsCSyn absCSyn/AbsCUtils codeGen/CgMonad codeGen/CgUsages codeGen/CgStackery codeGen/CgRetConv codeGen/SMRep codeGen/ClosureInfo codeGen/CgBindery codeGen/CgUpdate codeGen/CgHeapery codeGen/CgClosure codeGen/CgTailCall codeGen/CgCon codeGen/CgCase codeGen/CgConTbls codeGen/CgLetNoEscape codeGen/CgExpr codeGen/CodeGen absCSyn/Costs absCSyn/PprAbsC parser/UgenAll reader/PrefixSyn reader/PrefixToHs reader/ReadPrefix main/MkIface nativeGen/Stix nativeGen/MachRegs nativeGen/MachMisc nativeGen/MachCode nativeGen/PprMach nativeGen/StixInfo nativeGen/StixMacro nativeGen/StixInteger nativeGen/StixPrim nativeGen/AbsCStixGen nativeGen/RegAllocInfo nativeGen/AsmRegAlloc nativeGen/AsmCodeGen main/Main
              do
                  echo $name
                  temp=$(mktemp -d)
                  cat main/Main.hs main.hs > $temp/main.hs
                  ${ghc}/lib/hsc ,-N ,$temp/main.hs -module-number$i $(((i < 31)) && echo "-fno-implicit-prelude") -fglasgow-exts -fsimplify [ -fdo-case-elim -fmax-simplifier-iterations3 ] -himap=std%.hi:exts%.hi:absCSyn%.hi:basicTypes%.hi:codeGen%.hi:coreSyn%.hi:deSugar%.hi:hsSyn%.hi:main%.hi:nativeGen%.hi:parser%.hi:prelude%.hi:profiling%.hi:reader%.hi:rename%.hi:simplCore%.hi:simplStg%.hi:specialise%.hi:stgSyn%.hi:stranal%.hi:typecheck%.hi:types%.hi:utils%.hi:../lib/std%.hi -hifile=$name.hi -C=$name.hc -- ,main.hs
                  rm -r $temp
                  sed -i 's/^__interface \([A-Za-z_]*\) 0 where$/__interface \1 0 0 where/' $name.hi
                  sed -i 's/^\([^_i0].*\)$/0 \1/' $name.hi
                  sed -i 's/^\(i[^mn].*\)$/0 \1/' $name.hi
                  sed -i 's/^\(import[^ ].*\)$/0 \1/' $name.hi
                  sed -i 's/^\(in[^s].*\)$/0 \1/' $name.hi
                  sed -i 's/^\(ins[^t].*\)$/0 \1/' $name.hi
                  sed -i 's/^\(inst[^a].*\)$/0 \1/' $name.hi
                  grep '^0 class ' $name.hi > $name.hi_class || true
                  grep -v '^0 class ' $name.hi > tmp || true
                  mv tmp $name.hi
                  grep '^0 infix' $name.hi > $name.hi_infix || true
                  grep -v '^0 infix' $name.hi > tmp || true
                  mv tmp $name.hi
                  cat $name.hi $name.hi_class $name.hi_infix > tmp
                  mv tmp $name.hi
                  i=$((i+1))
              done
              for name in */*.hc
              do
                  ../driver/ghc -monly-3-regs -Istd -Iparser '-#include "cbits/timezone.h"' '-#include "ctypes.h"' '-#include "hspincl.h"' -o $(echo $name | head -c-4).o -c $name
              done
            ''
        )
        + ''
          touch libhsp.a
        ''
        + (
          if interpreter then
            #cat std/PrelBase.hs std/PrelTup.hs std/Ix.hs std/PrelMaybe.hs std/PrelList.hs std/Monad.hs std/PrelST.hs std/PrelCCall.hs std/PrelAddr.hs std/PrelArr.hs std/Array.hs std/PrelNum.hs std/PrelPack.hs std/PrelIOBase.hs std/PrelDynamic.hs std/PrelException.hs std/PrelStable.hs std/PrelErr.hs std/Maybe.hs std/PrelNumExtra.hs std/PrelEither.hs std/PrelRead.hs std/PrelBounded.hs std/PrelForeign.hs std/PrelWeak.hs std/PrelHandle.hs std/Char.hs std/IO.hs std/Ratio.hs std/PrelConc.hs std/Prelude.hs */*.hs > $out/share/main.hs
            ''
              mkdir -p $out/share
              cat */*.hs > $out/share/main.hs
              echo '#!${bash}/bin/bash' > hsc
              echo 'temp=$(mktemp)' >> hsc
              echo 'for arg in $@' >> hsc
              echo 'do' >> hsc
              echo '    case $arg in' >> hsc
              echo '      ,-*)' >> hsc
              echo '        ;;' >> hsc
              echo '      ,*)' >> hsc
              echo '        cat $(echo $arg | tail -c+2) ${placeholder "out"}/share/main.hs > $temp' >> hsc
              echo '        ;;' >> hsc
              echo '    esac' >> hsc
              echo 'done' >> hsc
              echo '${ghc}/lib/hsc ,-N ,$temp -interpreter -fno-implicit-prelude +RTS -M90000000 -RTS -- $@ || sleep 86400' >> hsc
              echo 'rm $temp' >> hsc
              chmod a+x hsc
            ''
          else
            ''
              touch libHS.a
              touch libHS_cbits.a
              rm parser/main.o parser/printtree.o
              ../driver/ghc -L. -o hsc */*.o */*/*.o
              touch parser/main.o parser/printtree.o
            ''
        )
        + ''
          touch hsp
          cd ../..
          make -C ghc/lib
        ''
      else
        ''
          make
        ''
    )
    + ''
      runHook postBuild
    '';
    preBuild = lib.strings.optionalString (bootstrap != 0) ''
      make boot
    '';
    postBuild = lib.strings.optionalString (bootstrap == 0) ''
      ./configure
      make -C ghc/lib clean
      make -C ghc/lib boot
      make -C ghc/lib
      ./configure --prefix=$out ${lib.strings.enableFeature true "hc-boot"}
    '';
    installPhase = ''
      runHook preInstall
    ''
    + (
      if bootstrap == 1 then
        ''
          make -C ghc/compiler install
        ''
      else
        ''
          make install
        ''
    )
    + ''
      runHook postInstall
    '';
    postFixup =
      lib.strings.optionalString (bootstrap == 1) ''
        #rm $out/lib/hsc
        rm $out/lib/hsp
      ''
      + lib.strings.optionalString (interpreter && bootstrap == 2) ''
        exit 1
      '';
    env.fptools_cv_gnu_cpp = "${gcc.gcc}/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/cpp0";
    env.LIBRARY_PATH = lib.strings.makeLibraryPath [ gmp ];
    env.NIX_GCC_NEEDS_GREP = true;
  }
)
