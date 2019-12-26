#include <GLES/gl.h>
#define A(row,col)  a[(col<<2)+row]
#define B(row,col)  b[(col<<2)+row]
#define P(row,col)  product[(col<<2)+row]

/**
 * Perform a full 4x4 matrix multiplication.
 *
 * \param a matrix.
 * \param b matrix.
 * \param product will receive the product of \p a and \p b.
 *
 * \warning Is assumed that \p product != \p b. \p product == \p a is allowed.
 *
 * \note KW: 4*16 = 64 multiplications
 * 
 * \author This \c matmul was contributed by Thomas Malik
 */
void matmul4( GLfloat *product, const GLfloat *a, const GLfloat *b )
{
   GLint i;
   for (i = 0; i < 4; i++) {
      const GLfloat ai0=A(i,0),  ai1=A(i,1),  ai2=A(i,2),  ai3=A(i,3);
      P(i,0) = ai0 * B(0,0) + ai1 * B(1,0) + ai2 * B(2,0) + ai3 * B(3,0);
      P(i,1) = ai0 * B(0,1) + ai1 * B(1,1) + ai2 * B(2,1) + ai3 * B(3,1);
      P(i,2) = ai0 * B(0,2) + ai1 * B(1,2) + ai2 * B(2,2) + ai3 * B(3,2);
      P(i,3) = ai0 * B(0,3) + ai1 * B(1,3) + ai2 * B(2,3) + ai3 * B(3,3);
   }
}

void matvec3( GLfloat *product, const GLfloat *a, const GLfloat *b )
{
	GLfloat ans[3];
	ans[0] = A(0, 0) * b[0] + A(0, 1) * b[1] + A(0, 2) * b[2] + A(0, 3) * b[3];
	ans[1] = A(1, 0) * b[0] + A(1, 1) * b[1] + A(1, 2) * b[2] + A(1, 3) * b[3];
	ans[2] = A(2, 0) * b[0] + A(2, 1) * b[1] + A(2, 2) * b[2] + A(2, 3) * b[3];
	for (int i = 0; i < 3; i++)
		product[i] = ans[i];
}

/**
 * Multiply two matrices known to occupy only the top three rows, such
 * as typical model matrices, and orthogonal matrices.
 *
 * \param a matrix.
 * \param b matrix.
 * \param product will receive the product of \p a and \p b.
 */
void matmul34( GLfloat *product, const GLfloat *a, const GLfloat *b )
{
   GLint i;
   for (i = 0; i < 3; i++) {
      const GLfloat ai0=A(i,0),  ai1=A(i,1),  ai2=A(i,2),  ai3=A(i,3);
      P(i,0) = ai0 * B(0,0) + ai1 * B(1,0) + ai2 * B(2,0);
      P(i,1) = ai0 * B(0,1) + ai1 * B(1,1) + ai2 * B(2,1);
      P(i,2) = ai0 * B(0,2) + ai1 * B(1,2) + ai2 * B(2,2);
      P(i,3) = ai0 * B(0,3) + ai1 * B(1,3) + ai2 * B(2,3) + ai3;
   }
   P(3,0) = 0;
   P(3,1) = 0;
   P(3,2) = 0;
   P(3,3) = 1;
}

#undef A
#undef B
#undef P