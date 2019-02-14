(**************************************************************************)
(*                                                                        *)
(*     SMTCoq                                                             *)
(*     Copyright (C) 2011 - 2019                                          *)
(*                                                                        *)
(*     See file "AUTHORS" for the list of authors                         *)
(*                                                                        *)
(*   This file is distributed under the terms of the CeCILL-C licence     *)
(*                                                                        *)
(**************************************************************************)


(* Constr generation and manipulation *)
(* WARNING: currently, we map all the econstr into constr: we suppose
   that the goal does not contain existencial variables *)
val mklApp : Term.constr Lazy.t -> Term.constr array -> Term.constr
val gen_constant : string list list -> string -> Term.constr lazy_t

(* Int63 *)
val int63_modules : string list list
val int31_module : string list list
val cD0 : Term.constr lazy_t
val cD1 : Term.constr lazy_t
val cI31 : Term.constr lazy_t
val mkInt : int -> Term.constr
val cint : Term.constr lazy_t

(* PArray *)
val parray_modules : string list list
val cmake : Term.constr lazy_t
val cset : Term.constr lazy_t
val max_array_size : int
val mkArray : Term.types * Term.constr array -> Term.constr

(* Traces *)
val mkTrace :
  ('a -> Term.constr) ->
  ('a -> 'a) ->
  'b ->
  Term.constr Lazy.t ->
  Term.constr Lazy.t ->
  Term.constr Lazy.t ->
  Term.constr Lazy.t ->
  int -> Term.constr -> Term.constr -> 'a ref -> Term.constr

(* Differences between the two versions of Coq *)
val mkUConst :
  Term.constr -> Safe_typing.private_constants Entries.definition_entry
val mkTConst :
  Term.constr ->
  Term.constr ->
  Term.types -> Safe_typing.private_constants Entries.definition_entry
val error : string -> 'a
val coqtype : Term.types Future.computation
val declare_new_type : Names.variable -> Term.constr
val declare_new_variable : Names.variable -> Term.constr -> Term.constr
val extern_constr : Term.constr -> Constrexpr.constr_expr
val vernacentries_interp : Constrexpr.constr_expr -> unit
val pr_constr_env : Environ.env -> Term.constr -> Pp.std_ppcmds
val lift : int -> Constr.constr -> Constr.constr
val destruct_rel_decl : Context.Rel.Declaration.t -> Names.Name.t * Constr.t
val interp_constr : Environ.env -> Evd.evar_map -> Constrexpr.constr_expr -> Term.constr
val tclTHEN :
  unit Proofview.tactic -> unit Proofview.tactic -> unit Proofview.tactic
val tclTHENLAST :
  unit Proofview.tactic -> unit Proofview.tactic -> unit Proofview.tactic
val assert_before : Names.Name.t -> Term.types -> unit Proofview.tactic

val vm_conv : Reduction.conv_pb -> Term.types Reduction.kernel_conversion_function
val vm_cast_no_check : Term.constr -> unit Proofview.tactic
val cbv_vm : Environ.env -> Term.constr -> Term.types -> Term.constr

val mk_tactic :
  (Environ.env -> Evd.evar_map -> Term.constr -> unit Proofview.tactic) ->
  unit Proofview.tactic
val set_evars_tac : Term.constr -> unit Proofview.tactic
val ppconstr_lsimpleconstr : Ppconstr.precedence
val constrextern_extern_constr : Term.constr -> Constrexpr.constr_expr
val get_rel_dec_name : Context.Rel.Declaration.t -> Names.Name.t
val retyping_get_type_of : Environ.env -> Evd.evar_map -> Term.constr -> Term.constr


(* Micromega *)
module Micromega_plugin_Certificate = Micromega_plugin.Certificate
module Micromega_plugin_Coq_micromega = Micromega_plugin.Coq_micromega
module Micromega_plugin_Micromega = Micromega_plugin.Micromega
module Micromega_plugin_Mutils = Micromega_plugin.Mutils

val micromega_coq_proofTerm : Term.constr lazy_t
val micromega_dump_proof_term : Micromega_plugin_Certificate.Mc.zArithProof -> Term.constr


(* Types in the Coq source code *)
type tactic = unit Proofview.tactic
type names_id = Names.Id.t
type constr_expr = Constrexpr.constr_expr

(* EConstr *)
type econstr = EConstr.t
val econstr_of_constr : Term.constr -> econstr
