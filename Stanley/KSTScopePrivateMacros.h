//
//  KSTScopePrivateMacros.h
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#ifndef __KST_SCOPE_PRIVATE_MACROS__
#define __KST_SCOPE_PRIVATE_MACROS__

/**
 Everything taken verbaitim from https://github.com/jspahrsummers/libextobjc taking care to rename all the symbols so they won't conflict with other clients that use that library or other libraries that rely on it internally (e.g. ReactiveCocoa).
 */

/**
 Typedefs that kstOnExit relies on.
 */
typedef void (^kst_cleanupBlock_t)(void);

static inline void kst_executeCleanupBlock (__strong kst_cleanupBlock_t *block) {
    (*block)();
}

/**
 Private macros that kstkeypath relies upon.
 */
#define kstkeypath1(PATH) \
(((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define kstkeypath2(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

/**
 * Returns A and B concatenated after full macro expansion.
 */
#define kstmetamacro_concat(A, B) \
kstmetamacro_concat_(A, B)

/**
 * Returns the Nth variadic argument (starting from zero). At least
 * N + 1 variadic arguments must be given. N must be between zero and twenty,
 * inclusive.
 */
#define kstmetamacro_at(N, ...) \
kstmetamacro_concat(kstmetamacro_at, N)(__VA_ARGS__)

/**
 * Returns the number of arguments (up to twenty) provided to the macro. At
 * least one argument must be provided.
 *
 * Inspired by P99: http://p99.gforge.inria.fr
 */
#define kstmetamacro_argcount(...) \
kstmetamacro_at(20, __VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

/**
 * Returns the first argument given. At least one argument must be provided.
 *
 * This is useful when implementing a variadic macro, where you may have only
 * one variadic argument, but no way to retrieve it (for example, because \c ...
 * always needs to match at least one argument).
 *
 * @code
 
 #define varmacro(...) \
 metamacro_head(__VA_ARGS__)
 
 * @endcode
 */
#define kstmetamacro_head(...) \
kstmetamacro_head_(__VA_ARGS__, 0)

/**
 * Returns every argument except the first. At least two arguments must be
 * provided.
 */
#define kstmetamacro_tail(...) \
kstmetamacro_tail_(__VA_ARGS__)

/**
 * Decrements VAL, which must be a number between zero and twenty, inclusive.
 *
 * This is primarily useful when dealing with indexes and counts in
 * metaprogramming.
 */
#define kstmetamacro_dec(VAL) \
kstmetamacro_at(VAL, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)

/**
 * Increments VAL, which must be a number between zero and twenty, inclusive.
 *
 * This is primarily useful when dealing with indexes and counts in
 * metaprogramming.
 */
#define kstmetamacro_inc(VAL) \
kstmetamacro_at(VAL, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21)

/**
 * If A is equal to B, the next argument list is expanded; otherwise, the
 * argument list after that is expanded. A and B must be numbers between zero
 * and twenty, inclusive. Additionally, B must be greater than or equal to A.
 *
 * @code
 
 // expands to true
 metamacro_if_eq(0, 0)(true)(false)
 
 // expands to false
 metamacro_if_eq(0, 1)(true)(false)
 
 * @endcode
 *
 * This is primarily useful when dealing with indexes and counts in
 * metaprogramming.
 */
#define kstmetamacro_if_eq(A, B) \
kstmetamacro_concat(kstmetamacro_if_eq, A)(B)
#define kstmetamacro_head_(FIRST, ...) FIRST
#define kstmetamacro_tail_(FIRST, ...) __VA_ARGS__
#define kstmetamacro_consume_(...)
#define kstmetamacro_expand_(...) __VA_ARGS__

// IMPLEMENTATION DETAILS FOLLOW!
// Do not write code that depends on anything below this line.
#define kstmetamacro_concat_(A, B) A ## B

// metamacro_at expansions
#define kstmetamacro_at0(...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at1(_0, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at2(_0, _1, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at3(_0, _1, _2, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at4(_0, _1, _2, _3, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at5(_0, _1, _2, _3, _4, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at6(_0, _1, _2, _3, _4, _5, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at7(_0, _1, _2, _3, _4, _5, _6, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at8(_0, _1, _2, _3, _4, _5, _6, _7, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at9(_0, _1, _2, _3, _4, _5, _6, _7, _8, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at10(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at11(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at12(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at13(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at14(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at15(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at16(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at17(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at18(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at19(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, ...) kstmetamacro_head(__VA_ARGS__)
#define kstmetamacro_at20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...) kstmetamacro_head(__VA_ARGS__)

// metamacro_if_eq expansions
#define kstmetamacro_if_eq0(VALUE) \
kstmetamacro_concat(kstmetamacro_if_eq0_, VALUE)

#define kstmetamacro_if_eq0_0(...) __VA_ARGS__ kstmetamacro_consume_
#define kstmetamacro_if_eq0_1(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_2(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_3(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_4(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_5(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_6(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_7(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_8(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_9(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_10(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_11(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_12(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_13(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_14(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_15(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_16(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_17(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_18(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_19(...) kstmetamacro_expand_
#define kstmetamacro_if_eq0_20(...) kstmetamacro_expand_

#define kstmetamacro_if_eq1(VALUE) kstmetamacro_if_eq0(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq2(VALUE) kstmetamacro_if_eq1(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq3(VALUE) kstmetamacro_if_eq2(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq4(VALUE) kstmetamacro_if_eq3(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq5(VALUE) kstmetamacro_if_eq4(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq6(VALUE) kstmetamacro_if_eq5(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq7(VALUE) kstmetamacro_if_eq6(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq8(VALUE) kstmetamacro_if_eq7(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq9(VALUE) kstmetamacro_if_eq8(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq10(VALUE) kstmetamacro_if_eq9(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq11(VALUE) kstmetamacro_if_eq10(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq12(VALUE) kstmetamacro_if_eq11(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq13(VALUE) kstmetamacro_if_eq12(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq14(VALUE) kstmetamacro_if_eq13(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq15(VALUE) kstmetamacro_if_eq14(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq16(VALUE) kstmetamacro_if_eq15(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq17(VALUE) kstmetamacro_if_eq16(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq18(VALUE) kstmetamacro_if_eq17(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq19(VALUE) kstmetamacro_if_eq18(kstmetamacro_dec(VALUE))
#define kstmetamacro_if_eq20(VALUE) kstmetamacro_if_eq19(kstmetamacro_dec(VALUE))

#endif
