This repository contains two products.

-----------------

    First, most important the Next Delphi Yacc & Lex - Parser generator 
    by Roman Yankovsky
    (as described after the next section)

-----------------

    Second, a tool which can created test-projects from lex and yacc files.
    This second tool uses examples from the book Lex & Yacc written by:
    John Levine, Tony Mason ad Doug Brown.
    
    Not all examples are done yet, so errors can come up.
    These examples are in the directory "progs".
    
    This project is, like the one described below, under same conditions and license.
    
    How to use it:
    
    You don't need the directory ndYacclex. It is there for your convenience. The compiled executables
    are in the tools directory.
    
    Compile the project in the source-directory.
    
    In the configuration of the compiled tool, let all sources configureable in disabled controls 
    in the GUI of the tool point to this directory.
    
    Get yourself a working directory, where you want your to create test-project to come.
    Point the other two to your Yacc and Lex files. 
    
    In case that you don't have a Yacc-file but only a Lex-file, click on "default" in the Tool-GUI, and
    a default Yacc-file will be added.
    
    Contact:
        Contact for information about this test-gui to bert.verhees@rosa.nl
        No guarantee that you will get a reply.
        
        Contact information for Roman Yankovsky below.
        His project: https://github.com/RomanYankovsky/ndyacclex
    
    Below the README from Roman Yankovsky

-----------------



    Next Delphi Yacc & Lex - Parser generator toolset for Delphi
    Copyright (c) 2013 Roman Yankovsky <roman@yankovsky.me>

    Based on Delphi Yacc & Lex version 1.4
    Based on Turbo Pascal Lex and Yacc Version 4.1

    Copyright (c) 1990-92    Albert Graef <ag@muwiinfa.geschichte.uni-mainz.de>
    Copyright (C) 1996       Berend de Boer <berend@pobox.com>
    Copyright (c) 1998       Michael Van Canneyt <Michael.VanCanneyt@fys.kuleuven.ac.be>
    Copyright (c) 2004       Morris Johns, Christchurch, NZ.
    Copyright (c) 2003-2004  Michiel Rook <michiel@grendelproject.nl>
  
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
    
          
    -------------------------------------------------------------------------
    

    What:
    
    Next Delphi Yacc & Lex is a parser generator toolset for Delphi, based on
    Delphi Yacc & Lex, version 1.4 by Michiel Rook and Turbo Pascal Lex and Yacc,
    version 4.1, by Albert Graef et al.
    
    The primary goal is to clean up the code, and improve compatibility
    and maintainability.
    
    Why:
    
    The project started because the original Delphi Yacc & Lex did not compile well
    in Delphi XE3 and the last release or activity dates back to 2005.
    
    Contact:
    
    Please send any inquiries or suggestions to roman@yankovsky.me.
    
    		
    
    -------------------------------------------------------------------------
